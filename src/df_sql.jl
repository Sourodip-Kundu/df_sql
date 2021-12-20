module df_sql

#greet() = print("Hello World!")

include("data_type.jl")
include("CleanCol.jl")

using .DataType
using .CleanCol
 
using DataFrames, TableIO, LibPQ;

function _create_query(data_types)

    query_list = []

    for key in keys(data_types)

        push!(query_list, string(key," ", data_types[key]))

    end
    query = join(query_list, ", ")
    return query
end

function to_sql(df, conn, tabel_name)

    df = CleanCol._process_col(df)
    
    data_types = DataType._get_data_types(df)

    query = _create_query(data_types)

    ### Creating Table###############

    exe_s = string("CREATE TABLE ", tabel_name, " (", query, ");")
    result = LibPQ.execute(conn, exe_s)  
    
    write_table!(conn, tabel_name, df)
    println("!!!!!!!!Table Created Succesfully!!!!!!!")
    close(conn)
end


end # module
