class Pokemon

    attr_accessor :name, :type, :db, :hp
    attr_reader :id

    def initialize(id: nil, name: nil, type: nil, db:, hp: nil)
        @id = id
        @name = name
        @type = type
        @db = db
        @hp = hp
    end
    
    def self.save(name, type, db)
        sql = <<-SQL
        INSERT INTO pokemon (name, type)
        VALUES (?, ?);
        SQL
        
        db.execute(sql, name, type)
    end

    def self.find(id, db)
        sql = <<-SQL
        SELECT *
        FROM pokemon
        WHERE id = ?;
        SQL
        
        result = db.execute(sql, id)
        object = Pokemon.new(id: result[0][0], name: result[0][1], type: result[0][2], hp: result[0][3],db: db)
    end

    def alter_hp(nhp,db)
        sql = <<-SQL
        UPDATE pokemon
        SET hp = ?
        WHERE id = ?;
        SQL

        db.execute(sql, nhp, self.id)
    end


end


