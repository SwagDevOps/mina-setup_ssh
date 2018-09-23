# frozen_string_literal: true

Sham.config(FactoryStruct, :ssh_keys) do |c|
  c.attributes do
    {
      # Simple array of filepaths.
      array_faker: ->(count = 10) { Faker::Custom.domain_files(count) }
    }
  end
end
