get '/' do
  controller = Songbooks::Controllers::SongsController.new(params)
  controller.index

  controller.resulting_instance_variables.each do |var_name|
    instance_variable_set(var_name, controller.instance_variable_get(var_name))
  end

  haml controller.template, :layout => controller.layout
end

get '/songs/:identifier' do
  controller = Songbooks::Controllers::SongsController.new(params)
  controller.show

  controller.resulting_instance_variables.each do |var_name|
    instance_variable_set(var_name, controller.instance_variable_get(var_name))
  end

  haml controller.template, :layout => controller.layout
end