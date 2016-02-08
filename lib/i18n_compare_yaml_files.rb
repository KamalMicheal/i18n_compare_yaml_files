require 'i18n_compare_yaml_files/version'
require 'yaml'

module I18nCompareYamlFiles
  def self.compare(yaml_content_1, yaml_content_2)
    yaml_1 = {}
    yaml_2 = {}

    flattern_yaml '', clear_language_param(YAML.load(yaml_content_1)), yaml_1
    flattern_yaml '', clear_language_param(YAML.load(yaml_content_2)), yaml_2

    return_hash = {}

    # get the difference
    yaml_2.each do |k, v|
      return_hash[k] = v unless yaml_1.key? k
    end

    # include keys at yaml_1 with empty values
    yaml_1.each do |k, v|
      return_hash[k] = v if v.empty?
    end
    return_hash
  end

  private

  def self.flattern_yaml(preceding, yml_content, flat_yml)
    yml_content.each do |k, v|
      if v.is_a?(Hash)
        flattern_yaml(generate_key(preceding, k), v, flat_yml)
      else
        flat_yml[generate_key(preceding, k)] = v
      end
    end
  end

  def self.generate_key(preceding, key)
    if preceding.empty?
      key
    else
      "#{preceding}.#{key}"
    end
  end

  def self.clear_language_param(input_hash)
    input_hash.first[1]
  end
end
