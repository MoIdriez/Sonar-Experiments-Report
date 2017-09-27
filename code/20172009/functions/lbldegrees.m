function lbldegrees(angles, degrees, max)
    for i = 1:size(degrees, 2)
        first = find(angles==degrees(i), 1);
        last = find(angles==degrees(i), 1, 'last');
        
        line([first first], [0 max], 'Color', 'g', 'LineStyle', ':');   
        text(first, max-max/20, num2str(degrees(i)), 'FontSize', 4);
        line([last last], [0 max], 'Color', 'g', 'LineStyle', ':');   
    end
end

