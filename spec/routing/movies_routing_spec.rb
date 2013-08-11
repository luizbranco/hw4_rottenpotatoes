require 'spec_helper'

describe MoviesController do

  it { {get: '/movies/1/same_director'}.should route_to(controller: 'movies', action: 'same_director', id: '1') }

end


