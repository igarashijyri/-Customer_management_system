# NOTE: リモートフォームを使う予定がないので、form_withを非Ajaxに設定している
Rails.application.configure do
  config.action_view.form_with_generates_remote_forms = false
end