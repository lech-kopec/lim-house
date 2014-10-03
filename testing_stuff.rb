ActiveRecord::Schema.define(:version => 1) do
create_table "tbl", force: true do |t|
	t.integer "comp_id"
	t.integer "project_id"
	t.integer "player_id"
	t.integer "result"
	t.boolean "resultOK"
end


