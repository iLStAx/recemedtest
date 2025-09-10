defmodule Recemedtest.PractitionersTest do
  use Recemedtest.DataCase

  alias Recemedtest.Practitioners

  describe "practitioners" do
    alias Recemedtest.Practitioners.Practitioner

    import Recemedtest.PractitionersFixtures

    @invalid_attrs %{first_name: nil, last_name: nil, phone: nil, birthdate: nil, email: nil}

    test "list_practitioners/0 returns all practitioners" do
      practitioner = practitioner_fixture()
      { practitioners, _meta } = Practitioners.list_practitioners()
      assert  practitioners == [practitioner]
    end

    test "get_practitioner!/1 returns the practitioner with given id" do
      practitioner = practitioner_fixture()
      assert Practitioners.get_practitioner!(practitioner.id) == practitioner
    end

    test "create_practitioner/1 with valid data creates a practitioner" do
      valid_attrs = %{first_name: "Marco", last_name: "Salinas", phone: "+56999999999", birthdate: ~D[2025-09-07], email: "example@gmail.com"}

      assert {:ok, %Practitioner{} = practitioner} = Practitioners.create_practitioner(valid_attrs)
      assert practitioner.first_name == "Marco"
      assert practitioner.last_name == "Salinas"
      assert practitioner.phone == "+56999999999"
      assert practitioner.birthdate == ~D[2025-09-07]
      assert practitioner.email == "example@gmail.com"
    end

    test "create_practitioner/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Practitioners.create_practitioner(@invalid_attrs)
    end

    test "update_practitioner/2 with valid data updates the practitioner" do
      practitioner = practitioner_fixture()
      update_attrs = %{first_name: "Updated Name", last_name: "Updated Last Name", phone: "+56988888888", birthdate: ~D[2025-09-08], email: "updated@gmail.com"}

      assert {:ok, %Practitioner{} = practitioner} = Practitioners.update_practitioner(practitioner, update_attrs)
      assert practitioner.first_name == "Updated Name"
      assert practitioner.last_name == "Updated Last Name"
      assert practitioner.phone == "+56988888888"
      assert practitioner.birthdate == ~D[2025-09-08]
      assert practitioner.email == "updated@gmail.com"
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
