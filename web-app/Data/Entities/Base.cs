using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace Piscina.Data.Entities
{
    public class Base
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }

        public string UtenteCreazione { get; set; }
        public DateTime DataCreazione { get; set; }
        public string? UtenteUltimaModifica { get; set; }
        public DateTime? DataUltimaModifica { get; set; }
    }
}

