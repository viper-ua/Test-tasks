require_relative 'yaml_converter'

input_yaml = <<-YAML
'en.pets.types': Cat
'en.pets.types.cat': Cat
'en.pets.types.dog': Dog
'en.pets.title': My lovely pets
'en.actions.add': Add
'en.actions.remove': Remove

'en.language': <strong>Language</strong>
YAML

YAMLConverter.to_yml(input_yaml)
