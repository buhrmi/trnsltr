class TranslationsController < ApplicationController
  def create
    translations = params[:translations].permit!.to_hash
    for locale, translations in translations
      remove_empty(translations)
      content = YAML.dump({locale => translations})
      org = params[:org]
      repo = params[:repo]
      branch = params[:branch]
      path = "config/locales/#{locale}.yml"
      old_sha = github.repos.contents.get(org, repo, path).sha
      args = {
        path: path,
        message: 'Update translations via trnsltr.herokuapp.com',
        sha: old_sha,
        branch: branch,
        content: content
      }
      last_result = github.repos.contents.create org, repo, path, args
    end
    url = "https://github.com/#{org}/#{repo}/commit/#{last_result.commit.sha}"
    redirect_to url
  end

  private

  def remove_empty(translations)
    for key, value in translations
      if Hash === value
        remove_empty(value)
      elsif value.empty?
        translations.delete(key)
      end
    end
  end
end