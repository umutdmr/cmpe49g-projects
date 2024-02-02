function result = eval_line_sign(arr, a, b, c)
    % Evaluate the expression for each point in the array
    expression_result = a * arr(:, 1) + b * arr(:, 2) + c;

    result = 2 * (expression_result > 0) - 1;  % Points above the line
end