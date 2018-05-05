require 'test_helper'

class ScheduleTest < ActiveSupport::TestCase

  # TEST PARA LUGAR

  test "lugar con menos de 50 caracteres" do
      horario = Schedule.new(
        place: "asdf1asdf1asdf1asdf1asdf1asdf1asdf1asdf1asdf1asdf18123123123")
        assert_not horario.save, "Se guardo un lugar con mas de 50 caracteres"
  end

  test "lugar sin espacio al inicio" do
      horario = Schedule.new(
        place: " minombre")
        assert_not horario.save, "Se guardo un lugar con un espacio"
  end

  test "lugar con alfanumericos, gato y punto" do
    horario = Schedule.new(
      place: "-_$nombredehorario*")
      assert_not horario.save, "Se guardo un lugar con caracteres que no sean gato y punto"
  end

  # EL RESTO DE VALORES SE ENCUENTRAN VALIDADOS POR FORMATO
  
end
