class CharacterController < ApplicationController
  def profile
  end

  def index
    @episode = find_allespisodes1
    @episode2 = find_allepisodes2
  end

  def request_api(url)
    response = Excon.get(
      url,
      headers: {
        'X-RapidAPI-Host' => URI.parse(url).host
      }
    )
    return nil if response.status != 200
    JSON.parse(response.body)
  end

  def find_character(character)
    request_api("#{URI.encode(character)}")
  end

  def find_allespisodes1
    request_api("https://rickandmortyapi.com/api/character/")
  end

  def find_allepisodes2
    request_api("https://rickandmortyapi.com/api/character?page=2")
  end

  def characters
    @character = params[:characters]
    @list = []
    @character.each do |ch|
      u = find_character(ch)
      unless u
        flash[:alert] = 'Character not found'
        return render action: :profile
      end
      @list.append(find_character(ch))
    end

end
