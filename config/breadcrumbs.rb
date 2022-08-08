crumb :root do
  link "Home", root_path
end

crumb :items_new do
  link "出品", new_item_path
  parent :root
end

crumb :items_show do
  item = Item.find(params[:id])
  link "商品ページ", item_path(item)
  parent :root
end

crumb :order_items_show do
  item = Item.find(params[:item_id])
  link "商品ページ", item_path(item)
  parent :root
end

crumb :orders do
  item = Item.find(params[:item_id])
  link "購入ページ", item_orders_path(item)
  parent :order_items_show
end

crumb :item_search do
  link "商品検索", item_search_items_path
  parent :root
end

crumb :item_edit do
  link "商品情報編集", edit_item_path
  parent :items_show
end

crumb :user_new do
  link "ユーザー新規登録", new_user_registration_path
  parent :root
end

crumb :user_show do
  link "ユーザー情報", user_path(current_user.id)
  parent :root
end

crumb :user_edit do
  link "ユーザー情報の編集", edit_user_registration_path
  parent :user_show
end

crumb :user_sessions_new do
  link "ユーザー新規登録", new_user_session_path
  parent :root
end


# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).