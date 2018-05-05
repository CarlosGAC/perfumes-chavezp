require 'test_helper'

class ClientTest < ActiveSupport::TestCase

  # TESTS PARA NOMBRE

  test "nombre con menos de 50 caracteres" do
    cliente = Client.new(
      name: "asdf1asdf1asdf1asdf1asdf1asdf1asdf1asdf1asdf1asdf12")
    assert_not cliente.save, "Se guardo el nombre con mas de 50 caracteres"
  end

  test "nombre no nulo" do
    cliente = Client.new
    assert_not cliente.save, "Se guardo un cliente sin nombre"
  end

  test "nombre con alfanumericos mas punto" do
    cliente = Client.new(
      name: "carlos*")
    assert_not cliente.save, "Se guardo un cliente con un caracter no valido"
  end

  test "nombre sin espacio al inicio" do
    cliente = Client.new(
      name: " carlos")
    assert_not cliente.save, "Se guardo un nombre que comienza por espacio"
  end

  # TESTS PARA DIRECCION

  test "direccion con menos de 50 caracteres" do
    cliente = Client.new(
      name: "Carlos",
      address: "asdf1asdf1asdf1asdf1asdf1asdf1asdf1asdf1asdf1asdf12")
    assert_not cliente.save, "Se guardo una direccion con mas de 50 caracteres"
  end

  test "direccion con alfanumericos mas punto" do
    cliente = Client.new(
      name: "Carlos",
      address: "direccion1*")
    assert_not cliente.save, "Se guardo una direccion con un caracter no valido"
  end

  test "direccion sin espacio al inicio" do
    cliente = Client.new(
      name: "Carlos",
      address: " direccion1")
    assert_not cliente.save, "Se guardo una direccion que comienza por espacio"
  end

  # TESTS PARA NUMERO DE TELEFONO

  test "numeros con formato 000-000-0000" do
    cliente = Client.new(
      name: "Carlos",
      phone_number: "341-123-22-22"
    )
    assert_not cliente.save, "Se guardo una direccion que no esta en el formato valido"
  end

end
