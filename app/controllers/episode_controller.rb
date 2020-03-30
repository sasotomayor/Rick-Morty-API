class EpisodeController < ApplicationController
  def index
    @episode = find_allespisodes1
    @episode2 = find_allepisodes2
  end

  def search
    episodes = find_episode(params[:id])
    unless episodes
      flash[:alert] = 'Episode not found'
      return render action: :index
    end

    @episode = episodes
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
    request_api("https://rickandmortyapi.com/api/episode/#{URI.encode(episode)}")
  end

  def find_allespisodes1
    request_api("https://rickandmortyapi.com/api/episode/")
  end

  def find_allepisodes2
    request_api("https://rickandmortyapi.com/api/episode?page=2")
  end

  def episodes
    @id = params[:id]
    episodes = find_episode(params[:id])
    unless episodes
      flash[:alert] = 'Episode not found'
      return render action: :index
    end

    @episode = episodes
  end

end
