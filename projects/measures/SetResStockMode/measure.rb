# see the URL below for information on how to write OpenStudio measures
# http://nrel.github.io/OpenStudio-user-documentation/measures/measure_writing_guide/

# Adapted from Measure Picker measure
# https://github.com/NREL/OpenStudio-measures/blob/develop/NREL%20working%20measures/measure_picker/measure.rb

# start the measure
class SetResStockMode < OpenStudio::Ruleset::ModelUserScript

  # human readable name
  def name
    return "Set Res Stock Mode"
  end

  # human readable description
  def description
    return "Specifies which mode to use (e.g., National-Scale, PNW, etc.)."
  end

  # human readable description of modeling approach
  def modeler_description
    return "Based on the mode specified, the Meta-Measure will use the appropriate probability distribution files (as found in its resources subdirectory)."
  end

  # define the arguments that the user will input
  def arguments(model)
    args = OpenStudio::Ruleset::OSArgumentVector.new

    modes = OpenStudio::StringVector.new
    modes << "National"
    modes << "Pacific Northwest"
    
    mode = OpenStudio::Ruleset::OSArgument.makeChoiceArgument("mode", modes, true)
    mode.setDisplayName("Res Stock Mode")
    args << mode
    
    return args
  end

  # define what happens when the measure is run
  def run(model, runner, user_arguments)
    super(model, runner, user_arguments)

    # use the built-in error checking
    if !runner.validateUserArguments(arguments(model), user_arguments)
      return false
    end
    
    mode = runner.getStringArgumentValue("mode",user_arguments)
    
    runner.registerValue("mode", mode)

    return true

  end
  
end

# register the measure to be used by the application
SetResStockMode.new.registerWithApplication