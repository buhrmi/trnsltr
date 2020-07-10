class ReposController < ApplicationController
  def show
    @org = params[:org]
    @repo = params[:repo]
    @translations = {}
    @locales = []
    mashes = github.repos.contents.get @org, @repo, 'config/locales' rescue nil
    for mash in mashes
      continue unless mash.name.end_with? '.yml'
      locale = mash.name.split('.').first
      @locales << locale
      file = github.repos.contents.get @org, @repo, mash.path
      yml = Base64.decode64 file.content
      translations = YAML.load(yml)
      add(translations[locale], locale)
      
    end
  end


  def add translations, locale, prefix = ''
    for key, value in translations
      if Hash == value.class
        add(value, locale, "#{prefix + key}.")
      else
        @translations[prefix + key] ||= {}
        @translations[prefix + key][locale] = value
      end
    end
  end
end