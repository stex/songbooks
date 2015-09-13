module Songbooks
  module Controllers
    class Controller

      def template
        @template.to_sym
      end

      def layout
        (@layout || 'layouts/application').to_sym
      end

      def resulting_instance_variables
        instance_variables - [:@layout, :@params, :@template]
      end
    end
  end
end