module Tenacity
  module Associations
    module BelongsTo #:nodoc:

      def _t_cleanup_belongs_to_association(association)
        if association.dependent == :destroy
          association.associate_class._t_delete(self.send(association.foreign_key))
        elsif association.dependent == :delete
          association.associate_class._t_delete(self.send(association.foreign_key), false)
        end
      end

      private

      def belongs_to_associate(association)
        associate_id = self.send(association.foreign_key)
        clazz = association.associate_class
        clazz._t_find(associate_id)
      end

      def set_belongs_to_associate(association, associate)
        self.send "#{association.foreign_key}=", associate.id.to_s
      end

      module ClassMethods #:nodoc:
        def initialize_belongs_to_association(association)
          _t_initialize_belongs_to_association(association) if self.respond_to?(:_t_initialize_belongs_to_association)
        end

        def _t_stringify_belongs_to_value(record, association)
          record.send "#{association.foreign_key}=", record.send(association.foreign_key).to_s
        end
      end

    end
  end
end

