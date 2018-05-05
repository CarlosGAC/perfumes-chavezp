require 'test_helper'

class PerfumeTest < ActiveSupport::TestCase

  # TESTS PARA NOMBRE
  test "nombre no nulo" do
    perfume = Perfume.new
    assert_not perfume.save, "Se guardo el perfume sin nombre"
  end

  test "nombre con menos de 50 caracteres" do
      perfume = Perfume.new(
        name: "asdf1asdf1asdf1asdf1asdf1asdf1asdf1asdf1asdf1asdf18123123123")
        assert_not perfume.save, "Se guardo con mas de 50 caracteres"
  end

  test "nombre sin espacio al inicio" do
      perfume = Perfume.new(
        name: " minombre")
        assert_not perfume.save, "Se guardo un nombre con un espacio"
  end

  test "nombre con alfanumericos, gato y punto" do
    perfume = Perfume.new(
      name: "-_$nombredeperfume*")
      assert_not perfume.save, "Se guardo un nombre con caracteres que no sean gato y punto"
  end

  # LOS PRECIOS SE ENCUENTRAN VALIDADOS DESDE LA VISTA Y CON REGEX

  # TEST PARA ENUMERACIONES

  test "publico en el rango 0..3" do
    assert_raises ArgumentError do
      perfume = Perfume.new(
        name: "nombre",
        public_target: 4
      )
    end
  end

  # TODO: Corregir caso de prueba para categorias. CHECAR PRIMERO Perfume.rb

  test "categoria en el rango 0..3" do
    assert_raises ArgumentError do
      perfume = Perfume.new(
        name: "nombre",
        category: 2
      )
    end
  end

  test "clasificacion en el rango 0..3" do
    assert_raises ArgumentError do
      perfume = Perfume.new(
        name: "nombre",
        classification: 5
      )
    end
  end

  test "visibilidad en el rango 0..3" do
    assert_raises ArgumentError do
      perfume = Perfume.new(
        name: "nombre",
        visibility: 2
      )
    end
  end

end
