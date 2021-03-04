module ApplicationHelper
  def document_title
    return "#{@title} - Baukis2" if @title.present?
    "Baukis2" if @title.blank?
  end
end
