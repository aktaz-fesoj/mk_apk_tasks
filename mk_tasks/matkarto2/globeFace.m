function [] = globeFace(umin, umax, vmin, vmax, Du, Dv, du, dv, R, uk, vk, s0, proj, ub, vb)
    hold on;
    axis equal;
    
    % Background
    backgroundColor = [0 139 152] / 255;
    transpValue = 0.12;


    % Draw background
    u_bg = [-2*R, 2*R, 2*R, -2*R];
    v_bg = [-2*R, -2*R, 2*R, 2*R];
    fill(u_bg, v_bg, backgroundColor, 'EdgeColor', 'none', 'FaceAlpha', transpValue)


    % Create graticule
    [XM, YM, XP, YP] = graticule(umin, umax, vmin, vmax, Du, Dv, du, dv, R, uk, vk, s0, proj);

    % Draw graticule
    plot(XM', YM', 'k');
    plot(XP', YP', 'k');
    

    % Draw parametres of continets
    fillColor = [39 93 31] / 255;
    edgeColor = [39 93 31] / 255;
    transpValue = 0.20;

    % Draw - euroasia
    s0 = 0;
    file = 'continents_points/eur.txt';
    [XC, YC] = continent(R, uk, vk, s0, proj, file);
    fill(XC, YC, fillColor, 'EdgeColor', edgeColor, 'LineWidth', 0.35, 'FaceAlpha', transpValue);

    % Draw - america
    s0 = 0;
    file = 'continents_points/amer.txt';
    [XC, YC] = continent(R, uk, vk, s0, proj, file);
    fill(XC, YC, fillColor, 'EdgeColor', edgeColor, 'LineWidth', 0.35, 'FaceAlpha', transpValue);

    % Draw - greenland
    s0 = 0;
    file = 'continents_points/greenl.txt';
    [XC, YC] = continent(R, uk, vk, s0, proj, file);
    fill(XC, YC, fillColor, 'EdgeColor', edgeColor, 'LineWidth', 0.35, 'FaceAlpha', transpValue);

    % Draw - africa
    s0 = 0;
    file = 'continents_points/afr.txt';
    [XC, YC] = continent(R, uk, vk, s0, proj, file);
    fill(XC, YC, fillColor, 'EdgeColor', edgeColor, 'LineWidth', 0.35, 'FaceAlpha', transpValue);

    % Draw - madagascar
    s0 = 0;
    file = 'continents_points/afr_mad.txt';
    [XC, YC] = continent(R, uk, vk, s0, proj, file);
    fill(XC, YC, fillColor, 'EdgeColor', edgeColor, 'LineWidth', 0.35, 'FaceAlpha', transpValue);

    % Draw - antarctica
    s0 = 0;
    file = 'continents_points/antar.txt';
    [XC, YC] = continent(R, uk, vk, s0, proj, file);
    fill(XC, YC, fillColor, 'EdgeColor', edgeColor, 'LineWidth', 0.35, 'FaceAlpha', transpValue);

    % Draw - australia
    s0 = 0;
    file = 'continents_points/austr.txt';
    [XC, YC] = continent(R, uk, vk, s0, proj, file);
    fill(XC, YC, fillColor, 'EdgeColor', edgeColor, 'LineWidth', 0.35, 'FaceAlpha', transpValue);

    % Draw - tasmania
    s0 = 0;
    file = 'continents_points/tasm.txt';
    [XC, YC] = continent(R, uk, vk, s0, proj, file);
    fill(XC, YC, fillColor, 'EdgeColor', edgeColor, 'LineWidth', 0.35, 'FaceAlpha', transpValue);

    % Draw - new zeland
    s0 = 0;
    file = 'continents_points/newzel1.txt';
    [XC, YC] = continent(R, uk, vk, s0, proj, file);
    fill(XC, YC, fillColor, 'EdgeColor', edgeColor, 'LineWidth', 0.35, 'FaceAlpha', transpValue);
    s0 = 0;
    file = 'continents_points/newzel2.txt';
    [XC, YC] = continent(R, uk, vk, s0, proj, file);
    fill(XC, YC, fillColor, 'EdgeColor', edgeColor, 'LineWidth', 0.35, 'FaceAlpha', transpValue);


    % Draw boundary
    [XB, YB] = boundary(R, uk, vk, s0, proj, ub, vb);
    % Cutting lines
    plot(XB, YB,'r');

end
