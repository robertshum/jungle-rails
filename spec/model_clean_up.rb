def clean_up_tmp_files
  tmp_dir = Rails.root.join('public', 'uploads', 'tmp')
  FileUtils.rm_rf(tmp_dir) if File.directory?(tmp_dir)
end