class ProdReturnsController < ApplicationController

	respond_to :html, :js

	def new
		@ret = ProdReturn.new
	end

	def create
		new_date = "#{params[:auction_date][:day]}/#{params[:auction_date][:month]}/#{params[:auction_date][:year]}"
		
		@ret = current_user.prod_returns.build(params[:prod_return])
		
		@ret.auction_date = new_date
		@ret.status = 1
		
		comment_params = { content: "#{params[:comment]}", user_id: current_user.id }

		begin
			ProdReturn.transaction do
				@ret.save!
				@com = @ret.comments.create(comment_params)
			end
			rescue => e
				@ret = ProdReturn.new
				flash[:error] = "Blad w formularzu"
				render 'new'
				return
		end

		if params[:files]
			params[:files].each do |f|
				@ret.prattachments.create(pr_file: f)
			end
		end

		flash[:success] = "Dodano nowy ticket"
		redirect_to root_path
	end

	def show
		@ret = ProdReturn.find(params[:id])
		respond_to do |format|
			format.js { render js: "window.location = '#{prod_return_path(params[:id])}'"}
			format.html { render 'show' }
		end
	end


	def change_status
		@ret = ProdReturn.find(params[:prod_return][:ret])
		@ret.status = ApplicationHelper::ReturnsStatus[params[:prod_return][:status].to_sym]

		if @ret.status == 0
			@ret.destroy
			redirect_to root_path
		else
			begin
				ProdReturn.transaction do
					@ret.save!
					@comment = @ret.comments.create!(content:params[:comment][:content], user_id: params[:prod_return][:user_id])
					flash[:success] = "Zmiany wprowadzono"
					redirect_to root_path
				end
				rescue => e
					@ret = ProdReturn.new
					@comment = Comment.new
					flash[:error] = "Wystapil blad"
					redirect_to root_path	
					return
			end #begin of transaction
		end #if
	end

	def update
		@ret = ProdReturn.find(params[:id])
		@ret.update_attributes(params[:prod_return])
		#when adding only attachment theres no auction date so check params
		if params[:auction_date]
			new_date = "#{params[:auction_date][:day]}/#{params[:auction_date][:month]}/#{params[:auction_date][:year]}"
			@ret.auction_date = new_date
		end
		
		if @ret.save
			if params[:files]
				params[:files].each do |f|
					@ret.prattachments.create(pr_file: f)
				end
			end
			redirect_to root_path
		else
			flash[:error] = "Operacja nieudana"
			redirect_to root_path
		end

	end

	def edit
		@ret = ProdReturn.find(params[:id])
	end

	def show_edit
		render js: "window.location = '#{edit_prod_return_path(params[:id])}'"
	end

	def group_delete
		#@id = params["id"].to_s.gsub('chbx_','')
		#ProdReturn.find(@id).destroy
		@ids = params[:id]
		@ids.each do |id|
			ProdReturn.find(id.to_s.gsub('chbx_','')).destroy
		end

		home_page_records
	end

	def delete_att
		att = Prattachment.find(params[:id])
		prod_id = att.prod_return_id
		att.destroy
		@ret = ProdReturn.find(prod_id)
		#redirect_to 'show'
	end

	def group_delete_att
		@ids = params[:id]
		@ids.each do |id|
			ProdReturn.find(id.to_s.gsub('chbx_','')).prattachments.destroy_all
		end
		home_page_records
	end

	def search
		query = "%#{params[:q]}%"
		@search = ProdReturn.find(:all, conditions:["client_name LIKE ? OR auction_name LIKE ?", query, query]).paginate(page:params[:page], per_page:10)
	end

	def archive
		@ret = ProdReturn.where(status: 99).paginate(page:params[:page], per_page:15)
	end

	def send_backup
		@all = ProdReturn.order(:id)
		@all_coms = Comment.order(:id)
		prods = @all.gen_csv
		coms = @all_coms.gen_csv		
		DbBackup.backup_email(prods, coms).deliver
	end

end
