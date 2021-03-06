startcode ReceiveTextSql

            DECLARE @NOCOUNT VARCHAR(3) = 'OFF';
            IF ( (512 & @@OPTIONS) = 512 ) SET @NOCOUNT = 'ON';
            SET NOCOUNT ON;

            WITH message AS (SELECT TOP(1) * FROM {0}.{1} WITH (UPDLOCK, READPAST, ROWLOCK) WHERE [Expires] IS NULL OR [Expires] > GETUTCDATE() ORDER BY [RowVersion])
            DELETE FROM message
            OUTPUT deleted.Id, deleted.CorrelationId, deleted.ReplyToAddress, deleted.Recoverable, deleted.Headers, deleted.Body;
            IF(@NOCOUNT = 'ON') SET NOCOUNT ON;
            IF(@NOCOUNT = 'OFF') SET NOCOUNT OFF;
endcode
