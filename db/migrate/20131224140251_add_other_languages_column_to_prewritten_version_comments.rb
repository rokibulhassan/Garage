class AddOtherLanguagesColumnToPrewrittenVersionComments < ActiveRecord::Migration
  def change
    add_column :prewritten_comments, :body_ar, :string
	add_column :prewritten_comments, :body_bg, :string
	add_column :prewritten_comments, :body_cs, :string
	add_column :prewritten_comments, :body_da, :string
	add_column :prewritten_comments, :body_de, :string
	add_column :prewritten_comments, :body_es, :string
	add_column :prewritten_comments, :body_fa, :string
	add_column :prewritten_comments, :body_fi, :string
	add_column :prewritten_comments, :body_grc, :string
	add_column :prewritten_comments, :body_hu, :string
	add_column :prewritten_comments, :body_id, :string
	add_column :prewritten_comments, :body_it, :string
	add_column :prewritten_comments, :body_ja, :string
	add_column :prewritten_comments, :body_ko, :string
	add_column :prewritten_comments, :body_nl, :string
	add_column :prewritten_comments, :body_no, :string
	add_column :prewritten_comments, :body_pl, :string
	add_column :prewritten_comments, :body_pt, :string
	add_column :prewritten_comments, :body_ro, :string
	add_column :prewritten_comments, :body_ru, :string
	add_column :prewritten_comments, :body_sk, :string
	add_column :prewritten_comments, :body_sv, :string
	add_column :prewritten_comments, :body_tr, :string
	add_column :prewritten_comments, :body_vi, :string
	add_column :prewritten_comments, :body_zh, :string
	end
end
