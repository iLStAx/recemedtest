defmodule Recemedtest.PractitionersTest do
  use Recemedtest.DataCase

  alias Recemedtest.Practitioners

  describe "practitioners" do
    alias Recemedtest.Practitioners.Practitioner

    import Recemedtest.PractitionersFixtures

    @invalid_attrs %{first_name: nil, last_name: nil, phone: nil, birthdate: nil, email: nil}

    test "list_practitioners/0 returns all practitioners" do
      practitioner = practitioner_fixture()
      assert Practitioners.list_practitioners() == [practitioner]
    end

    test "get_practitioner!/1 returns the practitioner with given id" do
      practitioner = practitioner_fixture()
      assert Practitioners.get_practitioner!(practitioner.id) == practitioner
    end

    test "create_practitioner/1 with valid data creates a practitioner" do
      valid_attrs = %{first_name: "some first_name", last_name: "some last_name", phone: "some phone", birthdate: ~D[2025-09-07], email: "some email"}

      assert {:ok, %Practitioner{} = practitioner} = Practitioners.create_practitioner(valid_attrs)
      assert practitioner.first_name == "some first_name"
      assert practitioner.last_name == "some last_name"
      assert practitioner.phone == "some phone"
      assert practitioner.birthdate == ~D[2025-09-07]
      assert practitioner.email == "some email"
    end

    test "create_practitioner/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Practitioners.create_practitioner(@invalid_attrs)
    end

    test "update_practitioner/2 with valid data updates the practitioner" do
      practitioner = practitioner_fixture()
      update_attrs = %{first_name: "some updated first_name", last_name: "some updated last_name", phone: "some updated phone", birthdate: ~D[2025-09-08], email: "some updated email"}

      assert {:ok, %Practitioner{} = practitioner} = Practitioners.update_practitioner(practitioner, update_attrs)
      assert practitioner.first_name == "some updated first_name"
      assert practitioner.last_name == "some updated last_name"
      assert practitioner.phone == "some updated phone"
      assert practitioner.birthdate == ~D[2025-09-08]
      assert practitioner.email == "some updated email"
    end

    test "update_practitioner/2 with invalid data returns error changeset" do
      practitioner = practitioner_fixture()
      assert {:error, %Ecto.Changeset{}} = Practitioners.update_practitioner(practitioner, @invalid_attrs)
      assert practitioner == Practitioners.get_practitioner!(practitioner.id)
    end

    test "delete_practitioner/1 deletes the practitioner" do
      practitioner = practitioner_fixture()
      assert {:ok, %Practitioner{}} = Practitioners.delete_practitioner(practitioner)
      assert_raise Ecto.NoResultsError, fn -> Practitioners.get_practitioner!(practitioner.id) end
    end

    test "change_practitioner/1 returns a practitioner changeset" do
      practitioner = practitioner_fixture()
      assert %Ecto.Changeset{} = Practitioners.change_practitioner(practitioner)
    end
  end
end
