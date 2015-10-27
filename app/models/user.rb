class User < ActiveRecord::Base
	has_many :districts, class_name: 'District'
end