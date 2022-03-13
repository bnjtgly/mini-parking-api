module AdminApi
  module V1
    module Organizers
      class SetupParking
        include Interactor::Organizer

        organize CreateParking, CreateInvoice
      end
    end
  end
end
