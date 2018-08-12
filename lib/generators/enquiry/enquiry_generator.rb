class EnquiryGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('templates', __dir__)

  def copy_enquiry_file
    template "#{file_name}.erb", "public/enquiries/#{file_name}_#{DateTime.now.strftime('%Q')}.html"
  end

end
