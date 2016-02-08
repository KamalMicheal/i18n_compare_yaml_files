require 'spec_helper'
require 'yaml'

describe I18nCompareYamlFiles do
  it 'has a version number' do
    expect(I18nCompareYamlFiles::VERSION).not_to be nil
  end

  it 'should return flattern yaml' do
    file_content = 'en:
                      common:
                        all: All
                        all_categories: All Categories
                        login: Sign in
                        profile: Profile
                        modify_profile: Modify profile'
    flat_yml = {}

    yaml_content = I18nCompareYamlFiles.clear_language_param(YAML.load(file_content))
    I18nCompareYamlFiles.flattern_yaml('', yaml_content, flat_yml)
    expect(flat_yml.count).to eq(5)
    expect(flat_yml['common.all']).to eq('All')
  end

  it 'should compare yaml and return results and return empty hash' do
    file_1 = 'en:
                common:
                  all: All
                  all_categories: All Categories
                  login: Sign in
                  profile: Profile
                  modify_profile: Modify profile'
    file_2 = 'fr:
                common:
                  all: Tout
                  all_categories: Toutes catégories
                  login: Se connecter
                  profile: Profil
                  modify_profile: Modifier le profil'
    results = I18nCompareYamlFiles.compare(file_1, file_2)
    expect(results.count).to eq(0)
  end

  it 'should compare yaml and return results and return hash with ne element' do
    file_1 = 'en:
                common:
                  all: All
                  login: Sign in
                  profile: Profile
                  modify_profile: Modify profile'
    file_2 = 'fr:
                common:
                  all: Tout
                  all_categories: Toutes catégories
                  login: Se connecter
                  profile: Profil
                  modify_profile: Modifier le profil'
    results = I18nCompareYamlFiles.compare(file_1, file_2)
    expect(results.count).to eq(1)
  end
end
