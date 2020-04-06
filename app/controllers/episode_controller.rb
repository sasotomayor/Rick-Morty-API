class EpisodeController < ApplicationController
  def index
    @episode = find_allespisodes1
    @episode2 = find_allepisodes2
  end

  def character
    @character = params[:character]
    @list = []
    @character["episode"].each do |ep|
      @list.append(find_character(ep))
    end
    if (@character["origin"]["url"] != "")
      @origin = find_character(@character["origin"]["url"])
    else
    end
    @location = find_character(@character["location"]["url"])
  end

  def place
    @place = params[:place]
    @list = []
    @place["residents"].each do |r|
      @list.append(find_character(r))
    end
  end

  def search
    name = params[:id]
    episodes = find_episodebyname(name)
    characters = find_characterbyname(name)
    locations = find_locationbyname(name)


    @episode = episodes

    @character = characters

    @location = locations
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

  def find_episode(episode)
    request_api("https://integracion-rick-morty-api.herokuapp.com/api/episode/#{URI.encode(episode)}")
  end

  def find_episodebyname(name)
    request_api("https://integracion-rick-morty-api.herokuapp.com/api/episode/?name=#{URI.encode(name)}")
  end

  def find_characterbyname(name)
    request_api("https://integracion-rick-morty-api.herokuapp.com/api/character/?name=#{URI.encode(name)}")
  end

  def find_locationbyname(name)
    request_api("https://integracion-rick-morty-api.herokuapp.com/api/location/?name=#{URI.encode(name)}")
  end

  def find_allespisodes1
    request_api("https://integracion-rick-morty-api.herokuapp.com/api/episode/")
  end

  def find_allepisodes2
    request_api("https://integracion-rick-morty-api.herokuapp.com/api/episode?page=2")
  end

  def find_character(character)
    request_api("#{URI.encode(character)}")
  end

  def episodes
    @id = params[:id]
    episodes = find_episode(params[:id])
    unless episodes
      flash[:alert] = 'Episode not found'
      return render action: :index
    end
    @list = []
    @episode = episodes
    @characters = episodes["characters"]
    @characters.each do |ch|
      @list.append(find_character(ch))
    end
  end

end
