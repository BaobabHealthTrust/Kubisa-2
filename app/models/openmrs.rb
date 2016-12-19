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
          UPDATE person_name SET given_name = '#{row['given_name'].encrypt}'
          WHERE person_name_id = #{person_name_id};
EOF

        end

        unless row['middle_name'].blank?
          ActiveRecord::Base.connection.execute <<EOF
          UPDATE person_name SET middle_name = '#{row['middle_name'].encrypt}'
          WHERE person_name_id = #{person_name_id};
EOF

        end

        unless row['family_name'].blank?
          ActiveRecord::Base.connection.execute <<EOF
          UPDATE person_name SET family_name = '#{row['family_name'].encrypt}'
          WHERE person_name_id = #{person_name_id};
EOF

        end

        puts ".... Encrypted person_name_id: #{person_name_id}"
      end
      ################################## person_name ############################################





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
          UPDATE person_name SET given_name = '#{row['given_name'].decrypt}'
          WHERE person_name_id = #{person_name_id};
EOF

        end

        unless row['middle_name'].blank?
          ActiveRecord::Base.connection.execute <<EOF
          UPDATE person_name SET middle_name = '#{row['middle_name'].decrypt}'
          WHERE person_name_id = #{person_name_id};
EOF

        end

        unless row['family_name'].blank?
          ActiveRecord::Base.connection.execute <<EOF
          UPDATE person_name SET family_name = '#{row['family_name'].decrypt}'
          WHERE person_name_id = #{person_name_id};
EOF

        end

        puts ".... Decrypted person_name_id: #{person_name_id}"
      end
      ################################## person_name ############################################





    end




  end

end
