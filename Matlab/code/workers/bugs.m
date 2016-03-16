% Prints list of bugs and if they've been fixed (and by whom).
% If  anything (at all) is sent in, it will sort the list by priority
% status.

function bugs(varargin)

bugList = ...
    {
    'Error when plotting histogram of correlations between derived measures.' 'temporary solution: error returned in gr.plot if type is histogram'
    };


% If they asked for a sorted list...sort the list.
if ~isempty(varargin);
    show = varargin{1};
    switch lower(show)
        case 'priority'
            m = zeros( [size(bugList,1),1] );
            m(strcmpi(bugList(:,3),'high'))   = 1;
            m(strcmpi(bugList(:,3),'medium')) = 2;
            m(strcmpi(bugList(:,3),'low'))    = 3;
            [~,ind] = sort(m);
            bugList = bugList(ind,:);
        case 'status'
            m = zeros( [size(bugList,1),1] );
            m(strcmpi(bugList(:,2),'unresolved')) = 1;
            m(strcmpi(bugList(:,2),'resolved'))   = 2;
            [~,ind] = sort(m);
            bugList = bugList(ind,:);
        case 'assigned'
            m = zeros( [size(bugList,1),1] );
             m(strcmpi(bugList(:,4),'ph/dmf')) = 1;
             m(strcmpi(bugList(:,4),'dmf/ph')) = 1;
            m(strcmpi(bugList(:,4),'ph'))  = 2;
            m(strcmpi(bugList(:,4),'dmf')) = 3;
            [~,ind] = sort(m);
            bugList = bugList(ind,:);
        otherwise
            fprintf( 'Not sortable by requested input.\n\n' );
    end % switch
end % if

% Now print the list.
fprintf( '\n\nStatus of known issues\n--------------------\n\n');
for i = 1 : size(bugList, 1)
    fprintf( '[%d]: %s\n\tStatus:  %s\n\tPriority: %s\n\tAssigned: %s\n\tKnown since: %s\n\tDescription: %s\n\n', i, bugList{i,:} );
end % i

end % bugs