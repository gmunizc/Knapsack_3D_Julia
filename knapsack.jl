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
        print("It works!")
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

function get_largest_and_second_largest_dim(a, b, c)
    dim_dict = Dict(1 => "ai", 2 => "bi", 3 => "ci")
    dim = [a, b, c]
    dim_sorted = sort(dim)
    g1 = pop!(dim_sorted)
    g2 = pop!(dim_sorted)
    g1_idx = getindex(dim, g1)
    g2_idx = getindex(dim, g2)
    return dim_dict[g1_idx], g1, dim_dict[g2_idx], g2
    
end

function knapsack_available_space(J, knapsack)

end

function add_to_knapsack(item, J, knapsack)
    if length(J) == 0
        wi_dim, wi_value, hi_dim, hi_value = get_largest_and_second_largest_dim(item[2].ai, item[2].bi, item[2].ci)
        J[1] = (item, (xi = 0, yi = 0, zi = 0), (hi = hi_dim, wi = wi_dim))
    end


end


knapsack = (H = 100, W = 100, L = 100)
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
J = []




