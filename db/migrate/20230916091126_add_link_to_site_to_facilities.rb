class AddLinkToSiteToFacilities < ActiveRecord::Migration[6.1]
  def change
    add_column :facilities, :link_to_site, :string
  end
end
