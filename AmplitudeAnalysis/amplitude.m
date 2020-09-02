function [wba_engaged]=amplitude(t_max,t_min,theta_atan,P,Q)
%finding the wba amplitude for the engaged part
    %finding wba only for the frames where wing is engaged
    A=find(t_max>P & t_max<Q);
    B=find(t_min>P & t_min<Q);

    if length(A)<length(B) 
        B=B(1:length(A));
        else A=A(1:length(B));
    end

    clear i
    k=1;
    X(:,1)=t_max(A);
    X(:,2)=t_min(B);
    for i=1:length(A)
        wba_engaged(k)=abs(theta_atan(X(i,1))-theta_atan(X(i,2)))*(180/pi);
    k=k+1;
    end