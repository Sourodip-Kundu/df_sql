module CleanCol

using DataFrames

list1 = []
function _clean_col_name(col)

    
    pcol = col

    column = String(col)
    column = replace(column, " "=>"_")
    column = replace(column, "("=>"")
    column = replace(column, ")"=>"")
    column = replace(column, "["=>"")
    column = replace(column, "]"=>"")
    column = replace(column, "-"=>"_")

    if pcol != column
        
        # @warn string("Column name ", col , " is not in SQL standard column name, name is modified")
        push!(list1, col)
    end

    return column
    
end

function _process_col(df)
    for col in names(df)
        
        df = rename(df, "$col" => _clean_col_name(col))
    end
    if length(list1)>0
        @warn string("Column name for columns ", list1 , " is not in SQL standard column name, name is modified")

    end
    return df
    
end

end
