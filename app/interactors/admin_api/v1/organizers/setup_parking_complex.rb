module AdminApi
  module V1
    module Organizers
      class SetupParkingComplex
        include Interactor::Organizer

        organize CreateParkingComplex, CreateEntryPoint
      end
    end
    end
end
