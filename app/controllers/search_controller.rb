class SearchController < ApplicationController
  def index
    @words = Word.all.pluck :name
    if params[:search].present?
      words = @words
      search = search_params.reject { |k| search_params[k].blank? }.to_h.except(:exclude, :include_words)

      @words = words.select { |w| eval(search.map { |k, v| "w[#{k}] == '#{v}'" }.join(' && ')) }
      if search_params[:exclude].present?
        @words = @words.select do |w|
          eval(search_params[:exclude].split("").map do |x|
                 "!w.include?('#{x}')"
               end.join(' && '))
        end
      end
      if search_params[:include_words].present?
        @words = @words.select do |w|
          eval(search_params[:include_words].split("").map do |x|
                 "w.include?('#{x}')"
               end.join(' && '))
        end
      end

    end

    @words
  end

  def search_params
    params.require(:search).permit(:'0', :'1', :'2', :'3', :'4', :exclude, :include_words)
  end
end
