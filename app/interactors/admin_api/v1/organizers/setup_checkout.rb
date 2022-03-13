module AdminApi
  module V1
    module Organizers
      class SetupCheckout
        include Interactor::Organizer

        organize CreateCheckout, UpdateInvoice
      end
    end
  end
end
