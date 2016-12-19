module Openmrs

  def self.encrypt
    ActiveRecord::Base.transaction do 
      ################################## users ############################################
      users = ActiveRecord::Base.connection.select_all <<EOF
      SELECT * FROM users;
EOF

      (users || []).each do |user|
        user_id = user['user_id'].to_i;
        users = ActiveRecord::Base.connection.execute <<EOF
        UPDATE users SET username = '#{user['username'].encrypt}'
        WHERE user_id = #{user_id};
EOF

        puts ".... Encrypted user: #{user_id}"
      end
      ################################## users ############################################


      ################################## person_name ############################################
      names = ActiveRecord::Base.connection.select_all <<EOF
      SELECT * FROM person_name;
EOF

      (names || []).each do |row|
        person_name_id = row['person_name_id'].to_i;

        unless row['given_name'].blank?
          ActiveRecord::Base.connection.execute <<EOF
          UPDATE person_name SET given_name = "#{row['given_name'].encrypt}"
          WHERE person_name_id = #{person_name_id};
EOF

        end

        unless row['middle_name'].blank?
          ActiveRecord::Base.connection.execute <<EOF
          UPDATE person_name SET middle_name = "#{row['middle_name'].encrypt}"
          WHERE person_name_id = #{person_name_id};
EOF

        end

        unless row['family_name'].blank?
          ActiveRecord::Base.connection.execute <<EOF
          UPDATE person_name SET family_name = "#{row['family_name'].encrypt}"
          WHERE person_name_id = #{person_name_id};
EOF

        end

        puts ".... Encrypted person_name_id: #{person_name_id}"
      end
      ################################## person_name ############################################

      
      ################################## person_address ############################################
      ActiveRecord::Base.connection.execute <<EOF
        ALTER TABLE person_address
        CHANGE COLUMN `address1` `address1` VARCHAR(150) NULL DEFAULT NULL ,
        CHANGE COLUMN `address2` `address2` VARCHAR(150) NULL DEFAULT NULL ,
        CHANGE COLUMN `city_village` `city_village` VARCHAR(150) NULL DEFAULT NULL ;
EOF

      addresses = ActiveRecord::Base.connection.select_all <<EOF
      SELECT * FROM person_address;
EOF

      (addresses || []).each do |row|
        person_address_id = row['person_address_id'].to_i;

        unless row['address1'].blank?
          ActiveRecord::Base.connection.execute <<EOF
          UPDATE person_address SET address1 = "#{row['address1'].encrypt}"
          WHERE person_address_id = #{person_address_id};
EOF

        end

        unless row['address2'].blank?
          ActiveRecord::Base.connection.execute <<EOF
          UPDATE person_address SET address2 = "#{row['address2'].encrypt}"
          WHERE person_address_id = #{person_address_id};
EOF

        end

        unless row['city_village'].blank?
          ActiveRecord::Base.connection.execute <<EOF
          UPDATE person_address SET city_village = "#{row['city_village'].encrypt}"
          WHERE person_address_id = #{person_address_id};
EOF

        end

        puts ".... Encrypted person_address: #{person_address_id}"
      end
      ################################## person_address ############################################



      ################################## patient_identifier ############################################
      ActiveRecord::Base.connection.execute <<EOF
        ALTER TABLE patient_identifier
        CHANGE COLUMN `identifier` `identifier` VARCHAR(150) NOT NULL DEFAULT '' ;

EOF

      patient_identifiers = ActiveRecord::Base.connection.select_all <<EOF
      SELECT * FROM patient_identifier;
EOF

      (patient_identifiers || []).each do |row|
        patient_identifier_id = row['patient_identifier_id'].to_i;

        unless row['identifier'].blank?
          ActiveRecord::Base.connection.execute <<EOF
          UPDATE person_address SET identifier = "#{row['identifier'].encrypt}"
          WHERE patient_identifier_id = #{patient_identifier_id};
EOF

        end

        puts "Encrypted patient_identifier_id: #{patient_identifier_id}"
      end
      ################################## patient_identifier ############################################

      ################################## person_attribute ############################################
      ActiveRecord::Base.connection.execute <<EOF
        ALTER TABLE person_attribute
        CHANGE COLUMN `value` `identifier` VARCHAR(150) NOT NULL DEFAULT '' ;

EOF

      person_attributes = ActiveRecord::Base.connection.select_all <<EOF
      SELECT * FROM person_attribute;
EOF

      (person_attributes || []).each do |row|
        person_attribute_id = row['person_attribute_id'].to_i;

        unless row['value'].blank?
          ActiveRecord::Base.connection.execute <<EOF
          UPDATE person_attribute SET value = "#{row['value'].encrypt}"
          WHERE person_attribute_id = #{person_attribute_id};
EOF

        end

        puts "Encrypted person_attribute_id: #{person_attribute_id}"
      end
      ################################## person_attribute ############################################

    end

  end

  def self.decrypt
    ActiveRecord::Base.transaction do 
      ################################## users ############################################
      users = ActiveRecord::Base.connection.select_all <<EOF
      SELECT * FROM users;
EOF

      (users || []).each do |user|
        user_id = user['user_id'].to_i;
        users = ActiveRecord::Base.connection.execute <<EOF
        UPDATE users SET username = '#{user['username'].decrypt}'
        WHERE user_id = #{user_id};
EOF

        puts ".... Decrypted user: #{user_id}"
      end
      ################################## users ############################################
      
      ################################## person_name ############################################
      names = ActiveRecord::Base.connection.select_all <<EOF
      SELECT * FROM person_name;
EOF

      (names || []).each do |row|
        person_name_id = row['person_name_id'].to_i;

        unless row['given_name'].blank?
          ActiveRecord::Base.connection.execute <<EOF
          UPDATE person_name SET given_name = "#{row['given_name'].decrypt}"
          WHERE person_name_id = #{person_name_id};
EOF

        end

        unless row['middle_name'].blank?
          ActiveRecord::Base.connection.execute <<EOF
          UPDATE person_name SET middle_name = "#{row['middle_name'].decrypt}"
          WHERE person_name_id = #{person_name_id};
EOF

        end

        unless row['family_name'].blank?
          ActiveRecord::Base.connection.execute <<EOF
          UPDATE person_name SET family_name = "#{row['family_name'].decrypt}"
          WHERE person_name_id = #{person_name_id};
EOF

        end

        puts ".... Decrypted person_name_id: #{person_name_id}"
      end
      ################################## person_name ############################################

      ################################## person_address ############################################
      addresses = ActiveRecord::Base.connection.select_all <<EOF
      SELECT * FROM person_address;
EOF

      (addresses || []).each do |row|
        person_address_id = row['person_address_id'].to_i;

        unless row['address1'].blank?
          ActiveRecord::Base.connection.execute <<EOF
          UPDATE person_address SET address1 = "#{row['address1'].decrypt}"
          WHERE person_address_id = #{person_address_id};
EOF

        end

        unless row['address2'].blank?
          ActiveRecord::Base.connection.execute <<EOF
          UPDATE person_address SET address2 = "#{row['address2'].decrypt}"
          WHERE person_address_id = #{person_address_id};
EOF

        end

        unless row['city_village'].blank?
          ActiveRecord::Base.connection.execute <<EOF
          UPDATE person_address SET city_village = "#{row['city_village'].decrypt}"
          WHERE person_address_id = #{person_address_id};
EOF

        end

        puts ".... Decrypted person_address: #{person_address_id}"
      end
        
      ActiveRecord::Base.connection.execute <<EOF
        ALTER TABLE person_address
        CHANGE COLUMN `address1` `address1` VARCHAR(50) NULL DEFAULT NULL ,
        CHANGE COLUMN `address2` `address2` VARCHAR(50) NULL DEFAULT NULL ,
        CHANGE COLUMN `city_village` `city_village` VARCHAR(50) NULL DEFAULT NULL ;
EOF

      ################################## person_address ############################################

      ################################## patient_identifier ############################################
      patient_identifiers = ActiveRecord::Base.connection.select_all <<EOF
      SELECT * FROM patient_identifier;
EOF

      (patient_identifiers || []).each do |row|
        patient_identifier_id = row['patient_identifier_id'].to_i;

        unless row['identifier'].blank?
          ActiveRecord::Base.connection.execute <<EOF
          UPDATE person_address SET identifier = "#{row['identifier'].decrypt}"
          WHERE patient_identifier_id = #{patient_identifier_id};
EOF

        end

        puts "Encrypted patient_identifier_id: #{patient_identifier_id}"
      end
      
      ActiveRecord::Base.connection.execute <<EOF
        ALTER TABLE patient_identifier
        CHANGE COLUMN `identifier` `identifier` VARCHAR(50) NOT NULL DEFAULT '' ;

EOF

      ################################## patient_identifier ############################################

      ################################## person_attribute ############################################
      person_attributes = ActiveRecord::Base.connection.select_all <<EOF
      SELECT * FROM person_attribute;
EOF

      (person_attributes || []).each do |row|
        person_attribute_id = row['person_attribute_id'].to_i;

        unless row['value'].blank?
          ActiveRecord::Base.connection.execute <<EOF
          UPDATE person_attribute SET value = "#{row['value'].decrypt}"
          WHERE person_attribute_id = #{person_attribute_id};
EOF

        end

        puts "Decrypted person_attribute_id: #{person_attribute_id}"
      end
      
      ActiveRecord::Base.connection.execute <<EOF
        ALTER TABLE person_attribute
        CHANGE COLUMN `value` `identifier` VARCHAR(50) NOT NULL DEFAULT '' ;

EOF

      ################################## person_attribute ############################################

    end #rescue nil



    puts "Decrypted .... "
  end

end
