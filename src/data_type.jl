module DataType

include("CleanCol.jl")



# Global
DTYPE_MAP = Dict(
    "Int64"=> "bigint",
    "Float64"=> "double precision",
    "String"=> "varchar(255)",
    "bool" => "boolean",
    #"Dates.Time" => "timestamp"
)

nonmissing(TT::Type{Union{Missing,T}}) where T = T

function Dtype(df, c)

    try
        dtype = string(eltype(df[!, c]))
        return dtype
    catch 
        dtype = string(nonmissing(eltype(df[!, c]))) 
        return dtype
    end

end

function _get_data_types(df)

   

    data_types = Dict()

    for c in names(df)

        
        dtype = Dtype(df, c)
       
        
        if !(dtype in keys(DTYPE_MAP))

            data_types[c] = "varchar(255)"

        else
            data_types[c] = DTYPE_MAP[dtype]
        end
    end
    return data_types
    
end

end