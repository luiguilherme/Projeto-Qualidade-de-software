public with sharing class EmailMessagePayload {
    public EmailSettingsWrapper emailSettings;
    public List<CharacteristicWrapper> characteristic;

    public class EmailSettingsWrapper {
        public String recipient;
        public String templateId;
    }

    public class CharacteristicWrapper {
        public String name;
        public String value;
    }
}
