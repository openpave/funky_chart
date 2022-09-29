function funky_chart()

close all;
h = figure('Units','inches','Position',[2 1 6.5 8.7],'Renderer','painters','Color',[1 1 1]);

emod_range = [1 2.8];

ah_base = subplot(15,1,1);
ah_dn = subplot(15,1,2);
ah_dn_in = subplot(15,1,3);
ah_cbr = subplot(15,1,4);
ah_cbrs = subplot(15,1,5);
ah_emod = subplot(15,1,6);
ah_emod_ksi = subplot(15,1,7);
ah_rvalue = subplot(15,1,8);
ah_spt = subplot(15,1,9);
ah_ucs = subplot(15,1,10);
ah_ucs_psi = subplot(15,1,11);
ah_k = subplot(15,1,12);
ah_k_pci = subplot(15,1,13);

ah_aashto = subplot(15,1,14);
ah_uscs = subplot(15,1,15);

set(ah_base,'Box','off','Layer','bottom',...
        'XGrid','off','YGrid','off','TickDir','out','Clipping','off');
xlim(ah_base,emod_range);

ah = [ah_dn; ah_dn_in; ah_cbr; ah_cbrs; ah_emod; ah_emod_ksi; ah_rvalue;
    ah_spt; ah_ucs; ah_ucs_psi; ah_k; ah_k_pci; ah_aashto; ah_uscs];
pos = [0.05 0.05 0.14 0.14 0.23 0.23 0.33 0.32 0.42 0.42 0.52 0.52 0.78 0.98]; 
siz = [0    0    0    0    0    0    0    0    0    0    0    0    0.21 0.19];

for i = 1:length(ah)
    set(ah(i),'Box','off','Layer','bottom',...
        'XGrid','on','YGrid','off','TickDir','out','Clipping','off',...
        'FontName','Helvetica','FontSize',10,'TitleFontSizeMultiplier',1,'LabelFontSizeMultiplier',1);
    set(ah(i),'TickLength',0.5*get(ah(i),'TickLength'));
    pb = get(ah(i),'Position');
    if (i > 1 && pos(i) <= pos(i-1)+0.02)
        set(ah(i),'Position',[pb(1)/4 1-pos(i)+0.002 1-(1-pb(3))/4 max(siz(i),0.001)]);
        set(ah(i),'XAxisLocation','top');
    else
        set(ah(i),'Position',[pb(1)/4 1-pos(i) 1-(1-pb(3))/4 max(siz(i),0.001)]);
    end
    xlim(ah(i),emod_range);
end
xlabel(ah_dn,'DCP Penetration Index (mm/blow)');
xlabel(ah_dn_in,'(mil/blow)');
xlabel(ah_cbr,'In-situ CBR (%)');
xlabel(ah_cbrs,'Soaked CBR (%)');
xlabel(ah_emod,'Resilient Modulus (MPa)');
xlabel(ah_emod_ksi,'(ksi)');
xlabel(ah_rvalue,'R-Value');
xlabel(ah_spt,'SPT (mm/blow)');
xlabel(ah_ucs,'UCS (kPa)');
xlabel(ah_ucs_psi,'(psi)');
xlabel(ah_k,'k-Value (kPa/mm)');
xlabel(ah_k_pci,'(pci)');
for i = 1:length(ah)
    xh = get(ah(i),'xlabel');
    set(xh,'Units','normalized');
    p = get(xh,'position');
    if (i > 1 && pos(i) <= pos(i-1)+0.02)
        p(2) = 0.8*p(2);
    else
        p(2) = 0.8*p(2);
    end
    set(xh,'position',p,'FontName','Helvetica','FontSize',10,'FontWeight','bold');
end

pb1 = get(ah(1),'Position');
pb2 = get(ah(end),'Position');
set(ah_base,'Position',[pb1(1) pb2(2) pb1(3) pb1(2)+pb1(4)+0.025]);
ah_base.XAxis.Visible = false;
ah_base.YAxis.Visible = false;

x_dn = [200 100 50 20 10 5 2 1 0.5 0.2 0.1];
s_dn = [200 100:-10:20 10:-1:2 1:-0.1:0.1];
x_dn_in = [8000 4000 2000 1000 500 200 100 50 20 10];
s_dn_in = [8000 4000:-1000:2000 1000:-100:200 100:10:20 10:-1:1];
x_cbr = [2:2:10 20:20:100 200 400];
s_cbr = [1:10 20:10:100 200:100:500];
x_cbrs = x_cbr;
s_cbrs = s_cbr;
x_emod = [10 20 40 60 80 100 200 400 600 800 1000 2000];
s_emod = [10:10:90 100:100:1000 2000];
x_emod_ksi = [1 2 4 6 8 10 20 40 60 80 100 200];
s_emod_ksi = [1:1:9 10:10:100 200];
x_rvalue = [4 6 10 20 40 60 80];
s_rvalue = [1:1:9 10:10:90 95];
x_spt = fliplr([2 6 10 20 40 60 80 100 150]);
s_spt = fliplr([1:1:9 10:10:100 150]);
x_ucs = [100 200 400 800 2000];
s_ucs = [50:10:100 200:100:1000 2000:1000:4000];
x_ucs_psi = [6 10 20 40 60 100 200 400 600];
s_ucs_psi = [6:1:9 10:10:100 200:100:600];
x_k = [10 20 40 60 80 100 200 300];
s_k = [10:10:100 200:100:300];
x_k_pci = [50 100 200 400 600 1000];
s_k_pci = [40:10:100 200:100:1000 ];

emod2e = @(e) log10(e);
cbr2e = @(cbr) 1.21055556+0.66525202*log10(cbr);
cbrs2e = @(cbr) 1.41573986+0.60753745*log10(cbr);
rvalue2e = @(r) log10(380.56989398*atanh(r/100));
dn2e = @(dn) 2.64594644-0.59529914*log10(dn);
ucs2e = @(ucs) dn2e(10.^(3.62281141-1.00626091*log10(ucs)));
spt2e = @(spt) dn2e(10.^(-0.37156923+1.20149899*log10(spt)));
k2e = @(k) cbr2e(10.^(-1.76374804+1.52200313*log10(k)));

fv = {'emod','emod_ksi','cbr','cbrs','dn','dn_in','rvalue','spt','ucs','ucs_psi','k','k_pci'};
for f = 1:length(fv)
    fv_func = [regexprep(fv{f},'_(ksi|psi|in|pci)','') '2e'];
    ah_temp = eval(['ah_' fv{f}]);
    ah_temp.YAxis.Visible = 'off';    
    if contains(fv{f},'_ksi') || contains(fv{f},'_psi')
        x_temp = eval([fv_func '(x_' fv{f} '*6.89476)']);
        s_temp = eval([fv_func '(s_' fv{f} '*6.89476)']);
    elseif contains(fv{f},'_in')
        x_temp = eval([fv_func '(x_' fv{f} '/1000*25.4)']);
        s_temp = eval([fv_func '(s_' fv{f} '/1000*25.4)']);
    elseif contains(fv{f},'_pci')
        x_temp = eval([fv_func '(x_' fv{f} '*0.271447138)']);
        s_temp = eval([fv_func '(s_' fv{f} '*0.271447138)']);
    else
        x_temp = eval([fv_func '(x_' fv{f} ')']);
        s_temp = eval([fv_func '(s_' fv{f} ')']);
    end
    t_temp = eval(['x_' fv{f}]);
    t_temp(x_temp < emod_range(1) | x_temp > emod_range(2)) = [];
    r_temp = s_temp([1 end]);
    r_temp(1) = max(r_temp(1),emod_range(1));
    r_temp(2) = min(r_temp(2),emod_range(2));
    x_temp(x_temp < emod_range(1) | x_temp > emod_range(2)) = [];
    s_temp(s_temp < emod_range(1) | s_temp > emod_range(2)) = [];
    ah_temp.XAxis.TickValues = x_temp;
    ah_temp.XAxis.MinorTickValues = s_temp;
    ah_temp.XAxis.MinorTick = 'on';
    ah_temp.XAxis.TickLabels = t_temp;
    ah_temp.XRuler.Axle.LineStyle = 'none';
    hold(ah_temp,'all');
    plot(ah_temp,r_temp,[0 0],'k-','LineWidth',1);
    hold(ah_temp,'off');
end

for i = length(ah)-1:length(ah)
    set(ah(i),'Box','on');
    ah(i).Color = 'none';
    xticks(ah(i),[]);
    yticks(ah(i),[]);
    ylim(ah(i),[0 siz(i)/0.02]);
end

aashto = {
    "A-1-a",5,209.0493811,299.6332521;
    "A-1-b",6,172.8820632,275.7904   ;
    "A-2-4",8,117.21092  ,240.8372588;
    "A-2-5",7,97.45851009,191.7794996;
    "A-2-6",6,75.12899402,138.2095225;
    "A-2-7",5,78.93305701,130.4701124;
    "A-3"  ,1,98.39038019,244.76398  ;
    "A-4"  ,4,75.12899402,199.94804  ;
    "A-5"  ,3,62.05284   ,175.81638  ;
    "A-6"  ,2,47.37473158,117.793843 ;
    "A-7-5",0,25.75232054,117.793843 ;
    "A-7-6",1,17.2369    ,77.1539066 ;
};
uscs = {
    "GW"     ,7,188.9422995,299.6332521;
    "GP"     ,5,138.2095225,275.7904   ;
    "GM"     ,0,119.1429599,299.6332521;
    "GC"     ,6,98.39038019,258.5535   ;
    "SW"     ,4,117.21092  ,219.1789177;
    "SP"     ,3,75.12899402,209.0493811;
    "SM"     ,2,77.1539066 ,258.5535   ;
    "SC"     ,1,77.1539066 ,193.05328  ;
    "ML"     ,0,47.37473158,102.7067067;
    "CL"     ,4,47.37473158,98.39038019;
    "MH"     ,5,25.75232054,77.1539066 ;
    "CH"     ,6,17.2369    ,93.07926   ;
};

phl = [];
thl = [];
x = [emod_range(1) emod_range(2)+0.005];
y = max([aashto{:,2}])+1.5;
phl(end+1) = patch(x([1 2 2 1]),[y y y+1 y+1],'k','LineStyle','none','LineWidth',0.1,'FaceColor',[0.75 0.75 0.75],'Parent',ah_aashto);
thl(end+1) = text(mean(emod_range),max([aashto{:,2}])+2.1,'AASHTO Soil Classification','Parent',ah_aashto,'HorizontalAlignment','center','FontWeight','bold');
for i = 1:size(aashto,1)
    x = [aashto{i,3} aashto{i,4}];
    y = aashto{i,2}+0.25;
    phl(end+1) = patch(log10(x([1 2 2 1])),[y y y+1 y+1],'k','LineStyle','-','LineWidth',0.1,'FaceColor','none','Parent',ah_aashto);
    thl(end+1) = text(mean(log10(x)),y+0.55,aashto{i,1},'Parent',ah_aashto,'HorizontalAlignment','center');
end
x = [emod_range(1) emod_range(2)+0.005];
y = max([uscs{:,2}])+1.5;
phl(end+1) = patch(x([1 2 2 1]),[y y y+1 y+1],'k','LineStyle','none','LineWidth',0.1,'FaceColor',[0.75 0.75 0.75],'Parent',ah_uscs);
thl(end+1) = text(mean(emod_range),max([uscs{:,2}])+2.1,'Unified Soil Classification System','Parent',ah_uscs,'HorizontalAlignment','center','FontWeight','bold');
for i = 1:size(uscs,1)
    x = [uscs{i,3} uscs{i,4}];
    y = uscs{i,2}+0.25;
    phl(end+1) = patch(log10(x([1 2 2 1])),[y y y+1 y+1],'k','LineStyle','-','LineWidth',0.1,'FaceColor','none','Parent',ah_uscs);
    thl(end+1) = text(mean(log10(x)),y+0.55,uscs{i,1},'Parent',ah_uscs,'HorizontalAlignment','center');
end
for i = length(thl)
    set(thl(i),'FontName','Helvetica','FontSize',10,'FontWeight','bold');
end

ah_base.XGrid = true;
ah_base.XTick = ah_emod.XTick;
ah_base.XMinorGrid = true;

set(h,'PaperOrientation','portrait');
set(h,'PaperUnits','inches');
set(h,'PaperType','usletter');
pb = get(h,'PaperSize');
set(h,'PaperPositionMode','manual');
set(h,'PaperPosition',[ 0 0 pb(1)-0 pb(2)-0]);
set(0,'ShowHiddenHandles','on');
th = [findobj(h,'Type','axes'); findobj(h,'Type','text')];
set(findobj(th,'Units','pixels'),'Units','points');
set(findobj(th,'FontUnits','pixels'),'FontUnits','points');
set(h,'ResizeFcn','');
if verLessThan('matlab','8.4')
    EraseModeH = [ ...
        findobj(h,'EraseMode','xor'); ...
        findobj(h,'EraseMode','none'); ...
        findobj(h,'EraseMode','background')];
    set(EraseModeH,'EraseMode','normal');
end

return