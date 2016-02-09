# I18nCompareYamlFiles

This gem is used to compare I18n yaml files and return differences.

# Usage
  I18nCompareYamlFiles.compare(File.read(path_to_first_yml), File.read(path_to_second_yml))

returns a hash with keys and values in second yml and don't exist in first yml
