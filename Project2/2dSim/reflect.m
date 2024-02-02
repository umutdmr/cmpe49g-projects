function result = reflect(a, b, c, arr)

    x = arr(:, 1);
    y = arr(:, 2);
    %z = zeros(size(arr));
    denominator = a^2 + b^2;
    
    x_reflected = x - 2 * (a*x + b*y + c) / denominator * a;
    y_reflected = y - 2 * (a*x + b*y + c) / denominator * b;
    result = [x_reflected, y_reflected];
end
