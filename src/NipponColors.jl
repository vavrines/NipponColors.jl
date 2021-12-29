module NipponColors

using Colors
using PyCall

export plot_color, dict_color

const dirc = @__DIR__

function plot_color()
    c = (
        ro = colorant"rgb(12,12,12)",
        sora = colorant"rgb(88,178,220)",
        ukon = colorant"rgb(239,187,36)",
        nae = colorant"rgb(134,192,102)",
        kohbai = colorant"rgb(225,107,140)",
        fujimurasaki = colorant"rgb(138,107,190)",
    )
    
    return c
end

function dict_color(file::AbstractString = "$(dirc)/../assets/nippon.json"; mode = :hex)
    dn = dict_name(file; mode = mode)
    fn = eval(mode)

    return fn(dn)
end

function hex(D::AbstractDict)
    dict = Dict{String,RGB}()
    for iter in eachindex(D.keys)
        try
            k = D.keys[iter]
            v = D.vals[iter]
            dict[k] = parse(Colorant, v)
        catch
            continue
        end
    end

    return dict
end

function rgb(D::AbstractDict)
    dict = Dict{String,RGB}()
    for iter in eachindex(D.keys)
        try
            k = D.keys[iter]
            v = D.vals[iter]
            dict[k] = parse(Colorant, "rgb($(v[1]),$(v[2]),$(v[3]))")
        catch
            continue
        end
    end

    return dict
end

function dict_name(file = "$(dirc)/../assets/nippon.json"; mode = :hex)
    py"""
    from json import load

    def convert_json(in_fname):
        with open(in_fname, 'r') as fp:
            c1 = load(fp)
            romanji = [d['romanji'].lower() for d in c1]
            kanji = [d['kanji'] for d in c1]
            color = [d['hex'] for d in c1]
            rgb = [d['rgb'] for d in c1]
            hls = [d['hls'] for d in c1]
            
            dict_list = []
            for i in range(len(color)):
                dict_list.append({
                    'romanji': romanji[i],
                    'kanji': kanji[i],
                    'hex': color[i],
                    'rgb': rgb[i],
                    'hls': hls[i]
                })

        return dict_list
    """
    list = py"convert_json"(file)
    fn = eval(mode)

    return fn(list)
end

function hex(list)
    dict = Dict{String,String}()
    for ele in list
        dict[ele["romanji"]] = ele["hex"]
        dict[ele["kanji"]] = ele["hex"]
    end

    return dict
end

function rgb(list)
    dict = Dict{String,Vector}()
    for ele in list
        dict[ele["romanji"]] = ele["rgb"]
        dict[ele["kanji"]] = ele["rgb"]
    end

    return dict
end

end
