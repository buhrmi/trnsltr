class ReposController < ApplicationController
  before_action :require_user

  def show
    @org = params[:org]
    @repo = params[:repo]
    @branch = 'master'
    @translations = {}
    @locales = []
    mashes = github.repos.contents.get @org, @repo, 'config/locales' rescue nil
    for mash in mashes
      continue unless mash.name.end_with? '.yml'
      file = github.repos.contents.get @org, @repo, mash.path
      yml = Base64.decode64 file.content
      translations = YAML.load(yml)
      for locale, values in translations
        @locales << locale
        add(values, locale) if values
      end if translations
    end if mashes
    @locales.uniq!
  end

  def index
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