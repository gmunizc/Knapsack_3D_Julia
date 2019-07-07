""" Hello Knapsack Problem:
    
    - Strategy 1
    Step1: Order them based on Weight
    Step2: Divide them in half
    Step3: Order each half based on Value
    Step4: Take the heaviest and most valuable until it all fits
    Step5: Take the lightest and most valuable if there is enough space left

    - Strategy 2
    Step1: Order them based on Weight
    Step2: Divide them in half
    Step3: Order each half based on Value
    Step4: Take one of the heaviest and most valuable 
    Step5: Take one of the lightest and most valuable
    Step6: Repeat until there is no space left

    - Strategy 3
    Step1: Order them based on Weight
    Step2: Divide them in half
    Step3: Order each half based on Value
    Step4: Take one of the lightest and most valuable until it all fits
    Step5: Take one of the heaviest and most valuable if there is enough space left

    - Strategy 4
    Step1: Order them based on Value
    Step2: Divide them in half
    Step3: Order each half based on Weight
    Step4: Take the heaviest and most valuable until it all fits
    Step5: Take the lightest and most valuable if there is enough space left

    - Strategy 5
    Step1: Order them based on Value
    Step2: Divide them in half
    Step3: Order each half based on Weight
    Step4: Take one of the heaviest and most valuable 
    Step5: Take one of the lightest and most valuable
    Step6: Repeat until there is no space left

    - Strategy 6
    Step1: Order them based on Value
    Step2: Divide them in half
    Step3: Order each half based on Weight
    Step4: Take one of the lightest and most valuable until it all fits
    Step5: Take one of the heaviest and most valuable if there is enough space left

    - Strategy 7
    Step1: Order them based on Value
    Step2: Take one by one from the most valuable to the least until there is no space left

"""

"""
Input Format:
    (H, W, L) are the dimensions of the knapsack 
    I is the set of items, with for each i ∈ I
    vi is the value of item i
    (ai, bi, ci) are the dimensions of item i
Output Format:
    V is the value of the solution.
    J ⊂ I is the set of select items, with for each i ∈ J, (xi,yi,zi) the coordinates of its bottom left corner;
    (hi,wi) the dimension selected as hight and width .

"""

function order_by_items_by(items, key)
    if key == "vi"
        print(items[1].vi)
        valuable_items = sort(items, rev=true, by = x -> x[1])
        print(valuable_items)
        return valuable_items
    else
        heaviest_items = sort(items, rev=true, by = x -> x[2].ai * x[2].bi * x[2].ci)
        print(heaviest_items)
        return heaviest_items
    end
end

function split_in_halves(items)
    if mod(length(items), 2) == 0
        n = convert(Int, length(items) / 2) 
    else
        n = convert(Int, length(items) / 2 + 0.5)
    end
    first_half = [items[i] for i in 1:n]
    second_half = [items[i] for i in n+1:length(items)]

    return first_half, second_half
end

function get_largest_to_smallest_dim_list(a, b, c)
    dim = [a, b, c]
    dim_sorted = sort(dim)
    g1 = pop!(dim_sorted)
    g2 = pop!(dim_sorted)
    g3 = pop!(dim_sorted)
    g1_idx = findall(x->x==g1, dim)[1]
    dim[g1_idx] = -1
    g2_idx = findall(x->x==g2, dim)[1]
    dim[g2_idx] = -1
    g3_idx = findall(x->x==g3, dim)[1]
    
    largest_to_smallest_dim_list = [(g1_idx, g1), (g2_idx, g2), (g3_idx, g3)]

    return largest_to_smallest_dim_list
    
end

function available_space(corner, knapsack)
    return (x = knapsack.W - corner.xi, y = knapsack.L - corner.yi, z = knapsack.H - corner.zi)
end

function is_enough_space(corner_space, item)
    item_dims = get_largest_to_smallest_dim_list(item[2].ai, item[2].bi, item[2].ci)
    space_dims = get_largest_to_smallest_dim_list(corner_space.x, corner_space.y, corner_space.z)
    enough = true
    relations = x = [((0,0),(0,0))]

    for i in 1:3
        space = space_dims[i][2] - item_dims[i][2]
        if space < 0
            relation = nothing
            enough = false
            break
        end
        push!(relations, (space_dims[i], item_dims[i]))
    end
    popfirst!(relations)
    return enough, relations
end

function order_relations_in_xyz(relations)
    return sort(relations, by = x -> x[1][1][1])
end

function get_wi_dim_and_hi_dim(relations)
    ordered_relations = order_relations_in_xyz(relations)
    dim_dict = Dict(1 => "ai", 2 => "bi", 3 => "ci")
    (wi = dim_dict[ordered_relations[1][2][1]], hi = dim_dict[ordered_relations[3][2][1]])
end

function calculate_new_corners(J, knapsack)
    return list_of_possible_corners
end

function add_to_knapsack(item, J, knapsack, list_of_possible_corners)
    if length(list_of_possible_corners) == 0
        return 0
    else
        for i in 1:length(list_of_possible_corners)
            corner = list_of_possible_corners[i]
            corner_space = available_space(corner, knapsack)
            enough, relations = is_enough_space(corner_space, item)
            if enough
                ordered_space_dims = order_relations_in_xyz(relations)
                wi_hi_dims = get_wi_dim_and_hi_dim(relations)
                push!(J,(item, (xi = corner.xi, yi = corner.yi, zi = corner.zi), wi_hi_dims))
            end
        end
    end


end

knapsack_dim = 100
knapsack = (H = knapsack_dim, W = knapsack_dim, L = knapsack_dim)
list_of_possible_corners = [(xi = 0, yi = 0, zi = 0)]
items = [(vi = 10, dim = (ai = 3, bi = 7, ci = 13)), (vi = 105, dim = (ai = 5, bi = 3, ci = 17)),
         (vi = 20, dim = (ai = 6, bi = 3, ci = 4)), (vi = 95, dim = (ai = 3, bi = 1, ci = 1)),
         (vi = 30, dim = (ai = 9, bi = 5, ci = 9)), (vi = 85, dim = (ai = 6, bi = 7, ci =23)), 
         (vi = 40, dim = (ai = 2, bi = 6, ci = 1)), (vi = 75, dim = (ai = 8, bi = 2, ci = 4)), 
         (vi = 50, dim = (ai = 1, bi = 5, ci = 12)), (vi = 65, dim = (ai = 2, bi = 2, ci = 9)), 
         (vi = 60, dim = (ai = 7, bi = 3, ci = 4)), (vi = 55, dim = (ai = 4, bi = 9, ci = 5)), 
         (vi = 70, dim = (ai = 30, bi = 2, ci = 9)), (vi = 45, dim = (ai = 9, bi = 9, ci = 8)), 
         (vi = 80, dim = (ai = 1, bi = 1, ci = 15)), (vi = 35, dim = (ai = 5, bi = 5, ci = 1)), 
         (vi = 90, dim = (ai = 5, bi = 9, ci = 1)), (vi = 25, dim = (ai = 3, bi = 2, ci = 9)), 
         (vi = 100, dim = (ai = 4, bi = 9, ci = 9)), (vi = 15, dim = (ai = 3, bi = 3, ci = 3))]
V = 0
item_zero = (vi = 0, dim = (ai = 0, bi = 0, ci = 0))
J = [(item_zero, (xi = 0, yi = 0, zi = 0), (hi = "ai", wi = "bi"))]




