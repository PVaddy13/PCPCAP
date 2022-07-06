########

# Write something

########

classdef app1 < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        PCPCAPUIFigure                 matlab.ui.Figure
        PerviousConcretePavementConstructionLabel  matlab.ui.control.Label
        AssistantProgramPCPCAPLabel    matlab.ui.control.Label
        Panel_2                        matlab.ui.container.Panel
        NewProjectButton               matlab.ui.control.Button
        Label                          matlab.ui.control.Label
        Label_HofRS                    matlab.ui.control.Label
        SuggestedHeightofRiserStripmmLabel  matlab.ui.control.Label
        RunButton                      matlab.ui.control.Button
        UIAxes                         matlab.ui.control.UIAxes
        ThicknessofPCLayermmEditFieldLabel  matlab.ui.control.Label
        ThicknessofPCLayermmEditField  matlab.ui.control.NumericEditField
        UnconsolidatedFreshDensityofPCkgm3EditFieldLabel  matlab.ui.control.Label
        UnconsolidatedFreshDensityofPCkgm3EditField  matlab.ui.control.NumericEditField
        Panel                          matlab.ui.container.Panel
        CheckBox_P                     matlab.ui.control.CheckBox
        CheckBox_HD                    matlab.ui.control.CheckBox
        CheckBox_PR                    matlab.ui.control.CheckBox
        InputTargetPropertyInformationLabel  matlab.ui.control.Label
        CheckBox_CS                    matlab.ui.control.CheckBox
        CompressiveStrengthMPaEditFieldLabel  matlab.ui.control.Label
        CompressiveStrengthMPaEditField  matlab.ui.control.NumericEditField
        PorosityLabel                  matlab.ui.control.Label
        PorosityEditField              matlab.ui.control.NumericEditField
        HardenedDensitykgm3EditFieldLabel  matlab.ui.control.Label
        HardenedDensitykgm3EditField   matlab.ui.control.NumericEditField
        PermeabilityRatecmsLabel       matlab.ui.control.Label
        PermeabilityRatecmsEditField   matlab.ui.control.NumericEditField
        FreshDensitykgm3Label          matlab.ui.control.Label
        Label_FD                       matlab.ui.control.Label
    end

    methods (Access = private)

        % Value changed function: CheckBox_CS
        function CheckBox_CSValueChanged(app, event)
            app.CheckBox_P.Value = 0;
            app.CheckBox_HD.Value = 0;
            app.CheckBox_PR.Value = 0;
           
            value = app.CheckBox_CS.Value;
            
        end

        % Value changed function: CheckBox_P
        function CheckBox_PValueChanged(app, event)
           app.CheckBox_CS.Value = 0;
           app.CheckBox_HD.Value = 0;
           app.CheckBox_PR.Value = 0;
           
           value = app.CheckBox_P.Value;
            
        end

        % Value changed function: CheckBox_HD
        function CheckBox_HDValueChanged(app, event)
           app.CheckBox_CS.Value = 0;
           app.CheckBox_P.Value = 0;
           app.CheckBox_PR.Value = 0;
           
           value = app.CheckBox_HD.Value;
            
        end

        % Value changed function: CheckBox_PR
        function CheckBox_PRValueChanged(app, event)
           app.CheckBox_CS.Value = 0;
           app.CheckBox_P.Value = 0;
           app.CheckBox_HD.Value = 0;
           
           value = app.CheckBox_PR.Value;
            
        end

        % Button pushed function: NewProjectButton
        function NewProjectButtonPushed(app, event)
           clc
           
           app.CheckBox_CS.Value = 0;
           app.CheckBox_P.Value = 0;
           app.CheckBox_HD.Value = 0;
           app.CheckBox_PR.Value = 0;
           
           app.ThicknessofPCLayermmEditField.Value = 0;
           app.Label_HofRS.Text = num2str(0);
           app.UnconsolidatedFreshDensityofPCkgm3EditField.Value = 0;
           app.CompressiveStrengthMPaEditField.Value = 0;
           app.PorosityEditField.Value = 0;
           app.HardenedDensitykgm3EditField.Value = 0;
           app.PermeabilityRatecmsEditField.Value = 0;
           app.Label_FD.Text = num2str(0);
           
           img = imread('AppPic.png');
           imshow(img,'parent',app.UIAxes);
        end

        % Button pushed function: RunButton
        function RunButtonPushed(app, event)
            clc
            img = imread('AppPic.png');
           imshow(img,'parent',app.UIAxes);
            
            if app.CheckBox_CS.Value == 1
                tarCS = app.CompressiveStrengthMPaEditField.Value;
                CFD = 21.357 * tarCS + 1683.9;
                
                UCFD = app.UnconsolidatedFreshDensityofPCkgm3EditField.Value;
                HofPC = app.ThicknessofPCLayermmEditField.Value;
                HofRS = HofPC * (CFD/UCFD - 1);
                app.Label_HofRS.Text = num2str(round(HofRS,2));
                
                P = (CFD-2565.4)/(-19.198);
                HD = (CFD-51.759)/1.0034;
                PR = exp((CFD-2020.6)/(-122.2));
                app.PorosityEditField.Value = round(P,2);
                app.HardenedDensitykgm3EditField.Value = round(HD,0);
                app.PermeabilityRatecmsEditField.Value = round(PR,2);
                app.Label_FD.Text = num2str(round(CFD,0));
            end         
            
            if app.CheckBox_P.Value == 1
                tarP = app.PorosityEditField.Value;
                CFD = -19.198*tarP+2565.4;
                
                UCFD = app.UnconsolidatedFreshDensityofPCkgm3EditField.Value;
                HofPC = app.ThicknessofPCLayermmEditField.Value;
                HofRS = HofPC * (CFD/UCFD - 1);
                app.Label_HofRS.Text = num2str(round(HofRS,2));
                
                CS = (CFD-1683.9)/21.357;
                HD = (CFD-51.759)/1.0034;
                PR = exp((CFD-2020.6)/(-122.2));
                app.CompressiveStrengthMPaEditField.Value = round(CS,2);
                app.HardenedDensitykgm3EditField.Value = round(HD,0);
                app.PermeabilityRatecmsEditField.Value = round(PR,2);
                app.Label_FD.Text = num2str(round(CFD,0));
            end
            
            if app.CheckBox_HD.Value == 1
                tarHD = app.HardenedDensitykgm3EditField.Value;
                CFD = 1.0034*tarHD+51.759;
                
                UCFD = app.UnconsolidatedFreshDensityofPCkgm3EditField.Value;
                HofPC = app.ThicknessofPCLayermmEditField.Value;
                HofRS = HofPC * (CFD/UCFD - 1);
                app.Label_HofRS.Text = num2str(round(HofRS,2));
                
                CS = (CFD-1683.9)/21.357;
                P = (CFD-2565.4)/(-19.198);
                PR = exp((CFD-2020.6)/(-122.2));
                app.CompressiveStrengthMPaEditField.Value = round(CS,2);
                app.PorosityEditField.Value = round(P,2);
                app.PermeabilityRatecmsEditField.Value = round(PR,2);
                app.Label_FD.Text = num2str(round(CFD,0));
            end
            
            if app.CheckBox_PR.Value == 1
                tarPR = app.PermeabilityRatecmsEditField.Value;
                CFD = -122.2*log(tarPR)+2020.6;
                
                UCFD = app.UnconsolidatedFreshDensityofPCkgm3EditField.Value;
                HofPC = app.ThicknessofPCLayermmEditField.Value;
                HofRS = HofPC * (CFD/UCFD - 1);
                app.Label_HofRS.Text = num2str(round(HofRS,2));
                
                CS = (CFD-1683.9)/21.357;
                P = (CFD-2565.4)/(-19.198);
                HD = (CFD-51.759)/1.0034;
                app.CompressiveStrengthMPaEditField.Value = round(CS,2);
                app.PorosityEditField.Value = round(P,2);
                app.HardenedDensitykgm3EditField.Value = round(HD,0);
                app.Label_FD.Text = num2str(round(CFD,0));
            end
            
        end
    end

    % App initialization and construction
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create PCPCAPUIFigure
            app.PCPCAPUIFigure = uifigure;
            app.PCPCAPUIFigure.Position = [100 100 700 371];
            app.PCPCAPUIFigure.Name = 'PCPCAP';

            % Create PerviousConcretePavementConstructionLabel
            app.PerviousConcretePavementConstructionLabel = uilabel(app.PCPCAPUIFigure);
            app.PerviousConcretePavementConstructionLabel.HorizontalAlignment = 'center';
            app.PerviousConcretePavementConstructionLabel.FontSize = 20;
            app.PerviousConcretePavementConstructionLabel.FontWeight = 'bold';
            app.PerviousConcretePavementConstructionLabel.Position = [126 338 449 25];
            app.PerviousConcretePavementConstructionLabel.Text = 'Pervious Concrete Pavement Construction';

            % Create AssistantProgramPCPCAPLabel
            app.AssistantProgramPCPCAPLabel = uilabel(app.PCPCAPUIFigure);
            app.AssistantProgramPCPCAPLabel.HorizontalAlignment = 'center';
            app.AssistantProgramPCPCAPLabel.FontSize = 20;
            app.AssistantProgramPCPCAPLabel.FontWeight = 'bold';
            app.AssistantProgramPCPCAPLabel.Position = [126 314 449 25];
            app.AssistantProgramPCPCAPLabel.Text = 'Assistant Program (PCPCAP)';

            % Create Panel_2
            app.Panel_2 = uipanel(app.PCPCAPUIFigure);
            app.Panel_2.Position = [11 13 679 293];

            % Create NewProjectButton
            app.NewProjectButton = uibutton(app.Panel_2, 'push');
            app.NewProjectButton.ButtonPushedFcn = createCallbackFcn(app, @NewProjectButtonPushed, true);
            app.NewProjectButton.FontSize = 14;
            app.NewProjectButton.FontWeight = 'bold';
            app.NewProjectButton.FontAngle = 'italic';
            app.NewProjectButton.Position = [16 262 100 26];
            app.NewProjectButton.Text = 'New Project';

            % Create Label
            app.Label = uilabel(app.Panel_2);
            app.Label.FontWeight = 'bold';
            app.Label.Position = [16 235 25 22];
            app.Label.Text = '';

            % Create Label_HofRS
            app.Label_HofRS = uilabel(app.Panel_2);
            app.Label_HofRS.HorizontalAlignment = 'center';
            app.Label_HofRS.FontSize = 18;
            app.Label_HofRS.FontWeight = 'bold';
            app.Label_HofRS.FontColor = [0.851 0.3294 0.102];
            app.Label_HofRS.Position = [585 10 79 22];
            app.Label_HofRS.Text = '0';

            % Create SuggestedHeightofRiserStripmmLabel
            app.SuggestedHeightofRiserStripmmLabel = uilabel(app.Panel_2);
            app.SuggestedHeightofRiserStripmmLabel.FontWeight = 'bold';
            app.SuggestedHeightofRiserStripmmLabel.Position = [357 10 220 22];
            app.SuggestedHeightofRiserStripmmLabel.Text = 'Suggested Height of Riser Strip (mm)';

            % Create RunButton
            app.RunButton = uibutton(app.Panel_2, 'push');
            app.RunButton.ButtonPushedFcn = createCallbackFcn(app, @RunButtonPushed, true);
            app.RunButton.FontSize = 14;
            app.RunButton.FontWeight = 'bold';
            app.RunButton.Position = [463 35 100 26];
            app.RunButton.Text = 'Run';

            % Create UIAxes
            app.UIAxes = uiaxes(app.Panel_2);
            app.UIAxes.FontSize = 8;
            app.UIAxes.Position = [334 71 330 221];

            % Create ThicknessofPCLayermmEditFieldLabel
            app.ThicknessofPCLayermmEditFieldLabel = uilabel(app.Panel_2);
            app.ThicknessofPCLayermmEditFieldLabel.FontWeight = 'bold';
            app.ThicknessofPCLayermmEditFieldLabel.Position = [16 235 167 22];
            app.ThicknessofPCLayermmEditFieldLabel.Text = 'Thickness of PC Layer (mm)';

            % Create ThicknessofPCLayermmEditField
            app.ThicknessofPCLayermmEditField = uieditfield(app.Panel_2, 'numeric');
            app.ThicknessofPCLayermmEditField.HorizontalAlignment = 'center';
            app.ThicknessofPCLayermmEditField.FontWeight = 'bold';
            app.ThicknessofPCLayermmEditField.Position = [277 235 51 22];

            % Create UnconsolidatedFreshDensityofPCkgm3EditFieldLabel
            app.UnconsolidatedFreshDensityofPCkgm3EditFieldLabel = uilabel(app.Panel_2);
            app.UnconsolidatedFreshDensityofPCkgm3EditFieldLabel.FontWeight = 'bold';
            app.UnconsolidatedFreshDensityofPCkgm3EditFieldLabel.Position = [16 203 262 22];
            app.UnconsolidatedFreshDensityofPCkgm3EditFieldLabel.Text = 'Unconsolidated Fresh Density of PC (kg/m3)';

            % Create UnconsolidatedFreshDensityofPCkgm3EditField
            app.UnconsolidatedFreshDensityofPCkgm3EditField = uieditfield(app.Panel_2, 'numeric');
            app.UnconsolidatedFreshDensityofPCkgm3EditField.HorizontalAlignment = 'center';
            app.UnconsolidatedFreshDensityofPCkgm3EditField.FontWeight = 'bold';
            app.UnconsolidatedFreshDensityofPCkgm3EditField.Position = [277 203 51 22];

            % Create Panel
            app.Panel = uipanel(app.Panel_2);
            app.Panel.Position = [10 5 318 188];

            % Create CheckBox_P
            app.CheckBox_P = uicheckbox(app.Panel);
            app.CheckBox_P.ValueChangedFcn = createCallbackFcn(app, @CheckBox_PValueChanged, true);
            app.CheckBox_P.Text = '';
            app.CheckBox_P.Position = [18 98 25 22];

            % Create CheckBox_HD
            app.CheckBox_HD = uicheckbox(app.Panel);
            app.CheckBox_HD.ValueChangedFcn = createCallbackFcn(app, @CheckBox_HDValueChanged, true);
            app.CheckBox_HD.Text = '';
            app.CheckBox_HD.Position = [18 66 25 22];

            % Create CheckBox_PR
            app.CheckBox_PR = uicheckbox(app.Panel);
            app.CheckBox_PR.ValueChangedFcn = createCallbackFcn(app, @CheckBox_PRValueChanged, true);
            app.CheckBox_PR.Text = '';
            app.CheckBox_PR.Position = [18 34 25 22];

            % Create InputTargetPropertyInformationLabel
            app.InputTargetPropertyInformationLabel = uilabel(app.Panel);
            app.InputTargetPropertyInformationLabel.HorizontalAlignment = 'center';
            app.InputTargetPropertyInformationLabel.FontSize = 14;
            app.InputTargetPropertyInformationLabel.FontWeight = 'bold';
            app.InputTargetPropertyInformationLabel.Position = [17 160 277 22];
            app.InputTargetPropertyInformationLabel.Text = 'Input Target Property Information';

            % Create CheckBox_CS
            app.CheckBox_CS = uicheckbox(app.Panel);
            app.CheckBox_CS.ValueChangedFcn = createCallbackFcn(app, @CheckBox_CSValueChanged, true);
            app.CheckBox_CS.Text = '';
            app.CheckBox_CS.Position = [18 129 25 22];

            % Create CompressiveStrengthMPaEditFieldLabel
            app.CompressiveStrengthMPaEditFieldLabel = uilabel(app.Panel);
            app.CompressiveStrengthMPaEditFieldLabel.FontSize = 14;
            app.CompressiveStrengthMPaEditFieldLabel.Position = [42 129 186 22];
            app.CompressiveStrengthMPaEditFieldLabel.Text = 'Compressive Strength (MPa)';

            % Create CompressiveStrengthMPaEditField
            app.CompressiveStrengthMPaEditField = uieditfield(app.Panel, 'numeric');
            app.CompressiveStrengthMPaEditField.Limits = [0 Inf];
            app.CompressiveStrengthMPaEditField.HorizontalAlignment = 'center';
            app.CompressiveStrengthMPaEditField.FontSize = 14;
            app.CompressiveStrengthMPaEditField.Position = [227 129 73 22];

            % Create PorosityLabel
            app.PorosityLabel = uilabel(app.Panel);
            app.PorosityLabel.FontSize = 14;
            app.PorosityLabel.Position = [44 98 82 22];
            app.PorosityLabel.Text = 'Porosity (%)';

            % Create PorosityEditField
            app.PorosityEditField = uieditfield(app.Panel, 'numeric');
            app.PorosityEditField.Limits = [0 Inf];
            app.PorosityEditField.HorizontalAlignment = 'center';
            app.PorosityEditField.FontSize = 14;
            app.PorosityEditField.Position = [227 98 73 22];

            % Create HardenedDensitykgm3EditFieldLabel
            app.HardenedDensitykgm3EditFieldLabel = uilabel(app.Panel);
            app.HardenedDensitykgm3EditFieldLabel.FontSize = 14;
            app.HardenedDensitykgm3EditFieldLabel.Position = [44 66 169 22];
            app.HardenedDensitykgm3EditFieldLabel.Text = 'Hardened Density (kg/m3)';

            % Create HardenedDensitykgm3EditField
            app.HardenedDensitykgm3EditField = uieditfield(app.Panel, 'numeric');
            app.HardenedDensitykgm3EditField.Limits = [0 Inf];
            app.HardenedDensitykgm3EditField.HorizontalAlignment = 'center';
            app.HardenedDensitykgm3EditField.FontSize = 14;
            app.HardenedDensitykgm3EditField.Position = [227 66 73 22];

            % Create PermeabilityRatecmsLabel
            app.PermeabilityRatecmsLabel = uilabel(app.Panel);
            app.PermeabilityRatecmsLabel.FontSize = 14;
            app.PermeabilityRatecmsLabel.Position = [44 34 159 22];
            app.PermeabilityRatecmsLabel.Text = 'Permeability Rate (cm/s)';

            % Create PermeabilityRatecmsEditField
            app.PermeabilityRatecmsEditField = uieditfield(app.Panel, 'numeric');
            app.PermeabilityRatecmsEditField.Limits = [0 Inf];
            app.PermeabilityRatecmsEditField.HorizontalAlignment = 'center';
            app.PermeabilityRatecmsEditField.FontSize = 14;
            app.PermeabilityRatecmsEditField.Position = [227 34 73 22];

            % Create FreshDensitykgm3Label
            app.FreshDensitykgm3Label = uilabel(app.Panel);
            app.FreshDensitykgm3Label.FontSize = 14;
            app.FreshDensitykgm3Label.Position = [44 6 184 22];
            app.FreshDensitykgm3Label.Text = 'Fresh Density (kg/m3)';

            % Create Label_FD
            app.Label_FD = uilabel(app.Panel);
            app.Label_FD.HorizontalAlignment = 'center';
            app.Label_FD.FontSize = 14;
            app.Label_FD.Position = [227 6 73 22];
            app.Label_FD.Text = '0';
        end
    end

    methods (Access = public)

        % Construct app
        function app = app1

            % Create and configure components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.PCPCAPUIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.PCPCAPUIFigure)
        end
    end
end
